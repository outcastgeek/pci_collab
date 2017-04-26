;; A dictionary of movie critics and their ratings of a small
;; set of movies

(import [logging]
        [pprint [pprint :as pp
                 pformat :as pf]]
        [math [sqrt]])

(require [utils.macros [*]])

;; Logger
(def logger (hylogger "recommendations"))

;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Movies
(def lady_movie "Lady in Water")
(def snake_movie "Snakes on a Plane")
(def luck_movie "Just My Luck")
(def super_movie "Superman Returns")
(def dupree_movie "You, me and Dupree")
(def night_movie "The Night Listener")

;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Judges
(def lisa "Lisa Rose")
(def gene "Gene Seymour")
(def mike "Michael Phillips")
(def claudia "Claudia Puig")
(def mick "Mick LaSalle")
(def jack "Jack Matthews")
(def toby "Toby")

;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Critics
(def critics
  {
   lisa
   {lady_movie 2.5
    snake_movie 3.5
    luck_movie 3.0
    super_movie 3.5
    dupree_movie 2.5
    night_movie 3.0}

   gene
   {lady_movie 3.0
    snake_movie 3.5
    luck_movie 1.5
    super_movie 5.0
    night_movie 3.0
    dupree_movie 3.5}

   mike
   {lady_movie 2.5
    snake_movie 3.0
    super_movie 3.5
    night_movie 4.0}

   claudia
   {snake_movie 3.5
    luck_movie 3.0
    night_movie 4.5
    super_movie 4.0
    dupree_movie 2.5}

   mick
   {lady_movie 3.0
    snake_movie 4.0
    luck_movie 2.0
    super_movie 3.0
    night_movie 3.0
    dupree_movie 2.0}

   jack
   {lady_movie 3.0
    snake_movie 4.0
    night_movie 3.0
    super_movie 5.0
    dupree_movie 3.5}

   toby
   {snake_movie 4.5
    dupree_movie 1.0
    super_movie 4.0}
   })

;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Operations

(defn sim_distance [prefs person1 person2]
  "Returns a distance-based similarity score for person1 and person2"
  (let [prefs1 (get prefs person1)
        prefs2 (get prefs person2)
        si (list-comp {item 1} [item prefs1] (get prefs item))] ;; Fix this !!!!
    (hydebug si)))

(defn run [&rest args]
  (hydebug "Critics: \n{}" (pf critics))
  (hydebug "{}'s rating for {} rating is {}"
           lisa lady_movie (-> critics (get lisa) (get lady_movie)))
  (hydebug "{}'s rating for {} rating is {}"
           toby snake_movie (-> critics (get toby) (get snake_movie)))
  (hydebug "All of {}'s critics are: \n{}"
           toby (pf (-> critics (get toby))))
  (sim_distance critics mick jack))

;; Main
(defmain [&rest args]
  (run args))

