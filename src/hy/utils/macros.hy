;; Utility Macros

;;;;;;;;;;;;;;;;
;;;; Logging

(defmacro hylogger [&optional name level formatter handler]
  `(let [logger_name (or ~name (str __name__))
         logger_formatter (or ~formatter
                              (logging.Formatter
                               "%(asctime)s - %(name)s - %(levelname)s - %(message)s"))
         logger_handler (or ~handler (logging.StreamHandler))
         logger_level (or ~level logging.DEBUG)
         logger (.getLogger logging logger_name)]
     (do
      (.setLevel logger logger_level)
      (.setLevel logger_handler logger_level)
      (.setFormatter logger_handler logger_formatter)
      (.addHandler logger logger_handler)
      logger)))

(defmacro hyprint [fmt_str &rest params]
  `(print (.format ~fmt_str ~@params)))

(defmacro hydebug [fmt_str &rest params]
  `(.debug logger (.format ~fmt_str ~@params)))

(defmacro hyinfo [fmt_str &rest params]
  `(.info logger (.format ~fmt_str ~@params)))

(defmacro hywarn [fmt_str &rest params]
  `(.warn logger (.format ~fmt_str ~@params)))

