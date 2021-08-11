(ns deathstar.main
  (:gen-class)
  (:require
   [clojure.core.async :as a :refer [chan go go-loop <! >! <!! >!!  take! put! offer! poll! alt! alts! close!
                                     pub sub unsub mult tap untap mix admix unmix pipe
                                     timeout to-chan  sliding-buffer dropping-buffer
                                     pipeline pipeline-async]]
   [clojure.string]
   [clojure.spec.alpha :as s]
   [clojure.java.io :as io]
   [datahike.api])
  (:import
   (javax.swing JFrame JLabel JButton SwingConstants JMenuBar JMenu JTextArea)
   (java.awt Canvas Graphics)
   (java.awt.event WindowListener KeyListener KeyEvent)))

(println "clojure.compiler.direct-linking" (System/getProperty "clojure.compiler.direct-linking"))
(clojure.spec.alpha/check-asserts true)
(do (set! *warn-on-reflection* true) (set! *unchecked-math* true))

(defonce stateA (atom nil))
(defonce ^JFrame jframe nil)

(defn -main [& args]
  (println ::-main)
  (let [data-dir (-> (io/file (System/getProperty "user.dir")) (.getCanonicalPath))]
    (reset! stateA {})
    (add-watch stateA :watch-fn (fn [k stateA old-state new-state] new-state))

    (let [jframe (JFrame. "i am deathstar program")]
      (doto jframe
        (.setDefaultCloseOperation JFrame/EXIT_ON_CLOSE)
        (.setSize 1600 1200)
        (.setLocationByPlatform true)
        (.setVisible true))
      (alter-var-root #'deathstar.main/jframe (constantly jframe)))

    (go)))


(comment

  (require
   '[deathstar.main]
   :reload)

  ;
  )

(comment

  (require
   '[datahike.api]
   :reload)

  (do
    (io/make-parents (System/getProperty "user.dir") "data" "db")
    (def cfg {:store {:backend :file
                      :path "./data/db"}})
    (datahike.api/create-database cfg)
    (def conn (datahike.api/connect cfg)))

  (do
    (datahike.api/release conn)
    (datahike.api/delete-database cfg))

  (datahike.api/transact conn [{:db/ident :name
                                :db/valueType :db.type/string
                                :db/cardinality :db.cardinality/one}
                               {:db/ident :words
                                :db/valueType :db.type/string
                                :db/cardinality :db.cardinality/one}])

  (datahike.api/transact conn [{:name  "BB-8", :words "Orange and white, one of a kind"}
                               {:name  "C-3PO", :words "Oh my.."}
                               {:name  "R2-D2", :words "We're going to the Dagobah system"}])

  (datahike.api/q '[:find ?e ?name ?words
                    :where
                    [?e :name ?name]
                    [?e :words ?words]]
                  @conn)

  (datahike.api/transact conn {:tx-data [{:db/id 2 :words "my first job was programming binary loadfilters - very similar to your vaporators in most respects"}]})

  (datahike.api/q {:query '{:find [?e ?name ?words]
                            :where [[?e :name ?name]
                                    [?e :words ?words]]}
                   :args [@conn]})

  (datahike.api/q '[:find ?words
                    :where
                    [?e :name "R2-D2"]
                    [?e :words ?words]]
                  (datahike.api/history @conn))

  ;
  )