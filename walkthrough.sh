#!/usr/bin/env bash

# Create Wallets
trinsic wallet create --description "Allison's Wallet" --name allison && \
trinsic wallet create --description "Airline's wallet" --name airline && \
trinsic wallet create --description "Vaccination Clinic" --name clinic

# Clinic signs credential
trinsic  --profile clinic issuer issue --document data/vaccination-certificate-unsigned.json --out vaccination-certificate-signed.json

# Allison adds credential to her wallet
trinsic --profile allison wallet insert-item --item vaccination-certificate-signed.json

# Allison searches her wallet for her credential
trinsic --profile allison wallet search --query "SELECT * FROM c WHERE c.id='<item_id>'"

# Allison creates a proof of her credential
trinsic --profile allison issuer create-proof --document-id "<item-id>" --out vaccination-certificate-partial-proof.json --reveal-document data/vaccination-certificate-frame.json

# Airline verifies proof
trinsic --profile airline issuer verify-proof --proof-document vaccination-certificate-partial-proof.json