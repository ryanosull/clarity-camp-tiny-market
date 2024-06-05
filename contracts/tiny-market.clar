
;; title: tiny-market
;; version:
;; summary:
;; description:

;; traits
;;

(use-trait nft-trait 'SP2PABAF9FTAJYNFZH93XENAJ8FVY99RRM50D2JG9.nft-trait.nft-trait)
(use-trait ft-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

;; token definitions
;;

;; constants
;;

(define-constant contract-owner tx-sender)

    ;; listing errors
    (define-constant err-expiry-in-past (err u1000))
    (define-constant err-price-zero (err u1001))

;; data vars
;;

;; data maps
;;

;; public functions
;;


;; read only functions
;;

;; private functions
;;

