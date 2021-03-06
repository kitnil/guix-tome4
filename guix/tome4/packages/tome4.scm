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
    (version "1.7.2")
    (source
     (origin
       (method url-fetch)
       (uri (and=> (getenv "HOME")
                   (lambda (home)
                     (string-append
                      "file://" home
                      "/Downloads"
                      "/tales_of_maj_eyal_ashes_of_urh_rok_1_7_2_42760.sh"))))
       (file-name (string-append name "-" version))
       (sha256
        (base32
         "05kzzd6gc37iakv7840rqxyirfbpz6126fn3k48r5a6lsfqw9wma"))))
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
            "data/noarch/game/game/addons/ashes-urhrok.teaac"
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
    (version "1.7.2")
    (source
     (origin
       (method url-fetch)
       (uri (and=> (getenv "HOME")
                   (lambda (home)
                     (string-append
                      "file://" home
                      "/Downloads"
                      "/tales_of_maj_eyal_embers_of_rage_1_7_2_42760.sh"))))
       (file-name (string-append name "-" version))
       (sha256
        (base32
         "0scf97g35an7bjdqi9vw7fz7kx247r45fqknmmxxfqvnrkr5a7g3"))))
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
            "data/noarch/game/game/addons/orcs.teaac"
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
    (version "1.7.2")
    (source
     (origin
       (method url-fetch)
       (uri (and=> (getenv "HOME")
                   (lambda (home)
                     (string-append
                      "file://" home
                      "/Downloads"
                      "/tales_of_maj_eyal_forbidden_cults_1_7_2_42760.sh"))))
       (file-name (string-append name "-" version))
       (sha256
        (base32
         "0wj7z0fzdz3amh2vf2jg82byx5i8isk0kzp8spmr9b0wzb3x2hac"))))
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
            "data/noarch/game/game/addons/cults.teaac"
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

(define-public tome4-with-addons-custom
  (package
    (inherit tome4-with-addons)
    (name "tome4-with-addons-custom")
    (version (package-version tome4))
    (arguments
     (substitute-keyword-arguments
         (package-arguments tome4-with-addons)
       ((#:phases phases)
        `(modify-phases ,phases
           (add-before 'install 'my-customizations
             (lambda* (#:key inputs #:allow-other-keys)
               (let ((unzip (string-append (assoc-ref inputs "unzip") "/bin/unzip"))
                     (zip (string-append (assoc-ref inputs "zip") "/bin/zip")))
                 (let ((archive (string-append "game/modules/tome-" ,version ".team")))
                   (mkdir-p "mod/class")
                   (system* unzip "-j" archive "mod/class/Game.lua" "-d" "mod/class")
                   ;; Change tactic grid color from yellow to black.
                   (substitute* "mod/class/Game.lua"
                     (("d5990880") "1a1a1a80"))
                   (system* zip archive "mod/class/Game.lua")))))))))))
