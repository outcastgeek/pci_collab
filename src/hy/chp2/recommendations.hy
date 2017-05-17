;; A dictionary of movie critics and their ratings of a small
;; set of movies

(import [logging]
        [pprint [pprint :as pp
                 pformat :as pf]]
        [math [sqrt]])

(import [data [*]])

(require [utils.macros [*]])

;; Logger
(def logger (hylogger "recommendations"))

;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Operations

(defn sim_distance [prefs person1 person2]
  "Returns a distance-based similarity score for person1 and person2"
  (let [prefs1 (get prefs person1)
        prefs2 (get prefs person2)
        ;; Get the list of shared_items
        si (dict-comp s2 1 [s1 prefs1
                            s2 prefs2] (= s1 s2))]
    ;; if they have no ratings in common, return 0
    (if (-> si len (= 0))
      0
      ;; Add up the squares of all the differences
      (let [sum_of_squares (->> (list-comp (-> (- (get prefs1 s2)
                                                  (get prefs2 s2))
                                               (pow 2))
                                           [s1 prefs1
                                            s2 prefs2]
                                           (= s1 s2))
                                (reduce +))
            similarity (/ 1 (+ 1 sum_of_squares))]
        (hydebug
         "< {} > and < {} > are [ {} ] similar"
         person1 person2
         similarity)
        ))
    ))

(defn sim_pearson [prefs person1 person2]
  "Returns the Pearson correlation coefficient for person1 and person2"
  (let [prefs1 (get prefs person1)
        prefs2 (get prefs person2)
        ;; Get the list of mutually rated items
        si (dict-comp s2 1 [s1 prefs1
                            s2 prefs2] (= s1 s2))]
    ;; Find the number of elements
    ;; If they have no ratings in common, return 0
    (if (-> si len (= 0))
      0
      ;; Add up all the preferences
      (let [sum1 (->> (list-comp it [it si
                                     s1 prefs1]
                                 (= it s1))
                      (reduce +))
            sum2 (->> (list-comp it [it si
                                     s2 prefs2]
                                 (= it s2))
                      (reduce +))]
        ))
    ))

(defn run [&rest args]
  (hydebug "Critics: \n{}" (pf critics))
  (hydebug "{}'s rating for {} rating is {}"
           lisa lady_movie (-> critics (get lisa) (get lady_movie)))
  (hydebug "{}'s rating for {} rating is {}"
           toby snake_movie (-> critics (get toby) (get snake_movie)))
  (hydebug "All of {}'s critics are: \n{}"
           toby (pf (-> critics (get toby))))
  (sim_distance critics lisa gene)
  (sim_distance critics mick jack))

;; Main
(defmain [&rest args]
  (run args))

