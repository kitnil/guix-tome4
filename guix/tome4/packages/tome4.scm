;; GNU Guix package recipe for tome4 addons
;; Copyright © 2020 Oleg Pykhalov <go.wigust@gmail.com>
;; Released under the GNU GPLv3 or any later version.

(define-module (tome4 packages tome4)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages)
  #:use-module (guix build-system trivial)
  #:use-module (guix download)
  #:use-module (guix packages)
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
    (version "1.6.4")
    (source
     (origin
       (method url-fetch)
       (uri (and=> (getenv "HOME")
                   (lambda (home)
                     (string-append
                      "file://" home
                      "/Downloads"
                      "/tales_of_maj_eyal_ashes_of_urh_rok_1_6_4_34357.sh"))))
       (file-name (string-append name "-" version))
       (sha256
        (base32
         "1h2prb7kks9yw0b125dmgmvj5vm5gfyns1jnfnkkh8lr1dnjixa9"))))
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
    (version "1.6.4")
    (source
     (origin
       (method url-fetch)
       (uri (and=> (getenv "HOME")
                   (lambda (home)
                     (string-append
                      "file://" home
                      "/Downloads"
                      "/tales_of_maj_eyal_embers_of_rage_1_6_4_34357.sh"))))
       (file-name (string-append name "-" version))
       (sha256
        (base32
         "05lqw1h8f1983a96kxwg5py6qawnjzrmbs0jfq500dw0wrf3r8b1"))))
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
