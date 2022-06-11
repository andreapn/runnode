# FORTA SCAN NODE Setup

## I. Overview
This guideline help easy to setup scanner node for Forta.

## II. Prerequisite
- Should register VPS instead of using public cloud like AWS, Azure. Because bandwidth cost will be cheaper.
- Assume that you use Ubuntu server because this quick script wrote for Ubuntu.

## III. Detail Steps

1. Customize `forta_setup.sh` file with below points:
- Replace `MyFortaPassPhrase` with your pass phrase
- Edit `FORTA_DIR` by your exact dir
- Edit `FORTA_PASSPHRASE` by you exact pass phrase
2. Run `forta_setup.sh` file by below command
    > sh forta_setup.sh

3. Run command to get *forta scanner address*
    > forta account address
4. Fund your address with some MATIC (about 0.2)
5. Run below command to start your forta scanner node, note that `owner address` is difference with your `scanner address`, `owner address` is an address that use receive reward, the address you own your seed phrase. 
    > forta register --owner-address <your_owner_address> --passphrase <your_pass_phrase>
    
    For example:
    > forta register --owner-address 0x956829.......7c9c558cA --passphrase MyFortaPassPhrase

    Run some next commands below to enable and start Forta as daemon:
    > sudo systemctl daemon-reload
    
    > sudo systemctl enable forta
    
    > sudo systemctl start forta

6. Submit form to register node scan with Forta Team https://docs.google.com/forms/d/e/1FAIpQLSe7p8LYECwDJetO2eCXBzs0H7dt7aEcoisexVteCIu7wVx_pg/viewform

