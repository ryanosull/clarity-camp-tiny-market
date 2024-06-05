
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


    ;; cancelling and fulfilling errors
(define-constant err-unknown-listing (err u2000)) ;; The listing the tx-sender wants to cancel or fulfil does not exist.
(define-constant err-unauthorised (err u2001)) ;; The tx-sender tries to cancel a listing it did not create.
(define-constant err-listing-expired (err u2002)) ;; The listing the tx-sender tries to fill has expired
(define-constant err-nft-asset-mismatch (err u2003)) ;; The provided NFT asset trait reference does not match the NFT contract of the listing. Since trait references cannot be stored directly in Clarity, they will have to be provided again when the buyer is trying to purchase an NFT. We have to make sure that the trait reference provided by the buyer matches the NFT contract provided by the seller.
(define-constant err-payment-asset-mismatch (err u2004)) ;; The provided payment asset trait reference does not match the payment asset contract of the listing. The same as the above but for the SIP010 being used to purchase the NFT.
(define-constant err-maker-taker-equal (err u2005)) ;; The maker and the taker (seller and the buyer) are equal. We will not permit users to purchase tokens from themselves using the same principal.
(define-constant err-unintended-taker (err u2006)) ;; The buyer is not the intended taker. If the seller defines an intended taker (buyer) for the listing, then only that principal can fulfil the listing.

;; Finally, we will implement a whitelist for NFT and payment asset contracts that the contract deployer controls. It makes for two additional error conditions:

(define-constant err-asset-contract-not-whitelisted (err u2007)) ;; The NFT asset the seller is trying to list is not whitelisted.
(define-constant err-payment-contract-not-whitelisted (err u2008)) ;; The requested payment asset is not whitelisted.




;; data vars
;;

(define-data-var listing-nonce uint u0)

;; data maps
;;

(define-map listings
	uint
	{
		maker: principal,
		taker: (optional principal),
		token-id: uint,
		nft-asset-contract: principal,
		expiry: uint,
		price: uint,
		payment-asset-contract: (optional principal)
	}
)


(define-map whitelisted-asset-contracts principal bool)

(define-read-only (is-whitelisted (asset-contract principal))
	(default-to false (map-get? whitelisted-asset-contracts asset-contract))
)

(define-public (set-whitelisted (asset-contract principal) (whitelisted bool))
	(begin
		(asserts! (is-eq contract-owner tx-sender) err-unauthorised)
		(ok (map-set whitelisted-asset-contracts asset-contract whitelisted))
	)
)

;; public functions
;;


;; read only functions
;;

;; private functions
;;

