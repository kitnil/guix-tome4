;; GNU Guix package recipe for tome4 addons
;; Copyright © 2020 Oleg Pykhalov <go.wigust@gmail.com>
;; Released under the GNU GPLv3 or any later version.

(define-module (tome4 packages tome4)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages games)
  #:use-module (gnu packages)
  #:use-module (guix build-system trivial)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (tome4 packages gogextract))

;;; Commentary:
;;;
;;; This module provides GNU Guix package recipes for Tales of Maj'Eyal
;;; (tome4) game DLC <https://te4.org/tome/dlc>.  You need to buy on GOG.com
;;; (<https://www.gog.com/>) and download DLCs to your user's $HOME/Downloads
;;; directory before using those recipes.
;;;
;;; Code:

(define-public tome4-ashes-urhrok
  (package
    (name "tome4-ashes-urhrok")
    (version "1.6.7")
    (source
     (origin
       (method url-fetch)
       (uri (and=> (getenv "HOME")
                   (lambda (home)
                     (string-append
                      "file://" home
                      "/Downloads"
                      "/tales_of_maj_eyal_ashes_of_urh_rok_1_6_7_36467.sh"))))
       (file-name (string-append name "-" version))
       (sha256
        (base32
         "1di6wqlk9gssiscd7r9jc75pdzlz719zmix41484csa7987h3yvw"))))
    (build-system trivial-build-system)
    (inputs
     `(("gogextract" ,gogextract)))
    (native-inputs
     `(("unzip" ,unzip)))
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (let ((file-name (string-append ,name "-" ,version ".sh")))
           (use-modules (guix build utils))
           (setenv "PATH"
                   (string-append
                    (assoc-ref %build-inputs "gogextract") "/bin" ":"
                    (assoc-ref %build-inputs "unzip") "/bin"))
           (copy-file (assoc-ref %build-inputs "source") file-name)
           (invoke "gogextract" file-name ".")
           (invoke "unzip" "data.zip")
           (install-file
            "data/noarch/game/t-engine4-linux64/game/addons/ashes-urhrok.teaac"
            %output)
           #t))))
    (home-page "https://www.gog.com/game/tales_of_majeyal_ashes_of_urhrok")
    (synopsis "Ashes of Urh'Rok DLC for Tales of Maj'Eyal game")
    (description "This package provides an Ashes of Urh'Rok DLC for Tales of
Maj'Eyal roguelike game.")
    (license license:gpl3+)))

(define-public tome4-embers-of-rage
  (package
    (name "tome4-embers-of-rage")
    (version "1.6.7")
    (source
     (origin
       (method url-fetch)
       (uri (and=> (getenv "HOME")
                   (lambda (home)
                     (string-append
                      "file://" home
                      "/Downloads"
                      "/tales_of_maj_eyal_embers_of_rage_1_6_7_36467.sh"))))
       (file-name (string-append name "-" version))
       (sha256
        (base32
         "145ycc3c0m6wgywpm6l2ijqa712z9cfx1v9lsjkndbxi942jai4q"))))
    (build-system trivial-build-system)
    (inputs
     `(("gogextract" ,gogextract)))
    (native-inputs
     `(("unzip" ,unzip)))
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (let ((file-name (string-append ,name "-" ,version ".sh")))
           (use-modules (guix build utils))
           (setenv "PATH"
                   (string-append
                    (assoc-ref %build-inputs "gogextract") "/bin" ":"
                    (assoc-ref %build-inputs "unzip") "/bin"))
           (copy-file (assoc-ref %build-inputs "source") file-name)
           (invoke "gogextract" file-name ".")
           (invoke "unzip" "data.zip")
           (install-file
            "data/noarch/game/t-engine4-linux64/game/addons/orcs.teaac"
            %output)
           #t))))
    (home-page "https://www.gog.com/game/tales_of_majeyal_embers_of_rage")
    (synopsis "Embers of Rage DLC for Tales of Maj'Eyal game")
    (description "This package provides an Embers of Rage DLC for Tales of
Maj'Eyal roguelike game.")
    (license license:gpl3+)))

(define-public tome4-forbidden-cults
  (package
    (name "tome4-forbidden-cults")
    (version "1.6.7")
    (source
     (origin
       (method url-fetch)
       (uri (and=> (getenv "HOME")
                   (lambda (home)
                     (string-append
                      "file://" home
                      "/Downloads"
                      "/tales_of_maj_eyal_forbidden_cults_1_6_7_36467.sh"))))
       (file-name (string-append name "-" version))
       (sha256
        (base32
         "0kmj67kl8rbg43c3qfar0vfngmmclgmlrbzf5dspjsixi23khw0j"))))
    (build-system trivial-build-system)
    (inputs
     `(("gogextract" ,gogextract)))
    (native-inputs
     `(("unzip" ,unzip)))
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (let ((file-name (string-append ,name "-" ,version ".sh")))
           (use-modules (guix build utils))
           (setenv "PATH"
                   (string-append
                    (assoc-ref %build-inputs "gogextract") "/bin" ":"
                    (assoc-ref %build-inputs "unzip") "/bin"))
           (copy-file (assoc-ref %build-inputs "source") file-name)
           (invoke "gogextract" file-name ".")
           (invoke "unzip" "data.zip")
           (install-file
            "data/noarch/game/t-engine4-linux64/game/addons/cults.teaac"
            %output)
           #t))))
    (home-page "https://www.gog.com/game/tales_of_majeyal_forbidden_cults")
    (synopsis "Forbidden Cults DLC for Tales of Maj'Eyal game")
    (description "This package provides a Forbidden Cults DLC for Tales of
Maj'Eyal roguelike game.")
    (license license:gpl3+)))

(define-public tome4-with-addons
  (package
    (inherit tome4)
    (name "tome4-with-addons")
    (version (package-version tome4))
    (inputs
     `(("tome4-ashes-urhrok" ,tome4-ashes-urhrok)
       ("tome4-embers-of-rage" ,tome4-embers-of-rage)
       ("tome4-forbidden-cults" ,tome4-forbidden-cults)
       ,@(package-inputs tome4)))
    (native-inputs
     `(("zip" ,zip)
       ,@(package-native-inputs tome4)))
    (arguments
     (substitute-keyword-arguments
         (package-arguments tome4)
       ((#:phases phases)
        `(modify-phases ,phases
           (add-after 'install 'install-addons
             (lambda* (#:key inputs outputs #:allow-other-keys)
               (let ((addons (string-append
                              (assoc-ref outputs "out")
                              "/share/tome4/game/addons")))
                 (install-file
                  (string-append (assoc-ref inputs "tome4-ashes-urhrok")
                                 "/ashes-urhrok.teaac")
                  addons)
                 (install-file
                  (string-append (assoc-ref inputs "tome4-embers-of-rage")
                                 "/orcs.teaac")
                  addons)
                 (install-file
                  (string-append (assoc-ref inputs "tome4-forbidden-cults")
                                 "/cults.teaac")
                  addons))))))))))
