;; GNU Guix package recipe for gogextract
;; Copyright © 2020 Oleg Pykhalov <go.wigust@gmail.com>
;; Released under the GNU GPLv3 or any later version.

(define-module (tome4 packages gogextract)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system trivial)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages python)
  #:use-module (gnu packages compression))

(define-public gogextract
  (let ((commit "6601b32feacecd18bc12f0a4c23a063c3545a095"))
    (package
      (name "gogextract")
      (version (git-version "0.0.1" "1" commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/Yepoleb/gogextract.git")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "0hh4hc9mskawsph859cx5n194qkwa3122gkcsywm917n77fncfq5"))))
      (build-system trivial-build-system)
      (inputs
       `(("python" ,python)))
      (arguments
       `(#:modules ((guix build utils))
         #:builder
         (begin
           (use-modules (guix build utils))
           (setenv "PATH"
                   (string-append
                    (assoc-ref %build-inputs "python") "/bin"))
           (copy-file (string-append (assoc-ref %build-inputs "source")
                                     "/gogextract.py")
                      "gogextract")
           (substitute* "gogextract"
             (("/usr/bin/env python3") (which "python3")))
           (install-file "gogextract" (string-append %output "/bin"))
           #t)))
      (home-page "https://github.com/Yepoleb/gogextract")
      (synopsis "Python script for unpacking GOG Linux installers")
      (description "This package provides a Python script for unpacking GOG
Linux installers.")
      (license license:expat))))
