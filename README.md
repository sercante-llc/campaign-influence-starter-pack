# Campaign Influence Starter Pack

This Starter Pack was developed for professionals who have already set up Connected Campaigns and Campaign Influence, and now want to understand what kind of reporting is available to them. If you need help with the setup, someone to bounce questions off of, or just a second set of eyes, you’re in luck: Sercante has helped many companies through Connected Campaigns & Campaign Influence Reporting. [Let's Chat >](https://sercante.com/contact-us/)

> This sample application is designed to run on Salesforce Platform. 

> This package is designed to both run independently (in a self contained scratch org) as well as be deployed to a Sandbox.


## Table of contents

- [Installing the Starter Pack Using a Scratch Org](#installing-the-starter-pack-using-a-scratch-org): This is the recommended option to explore the reports and dashboards.

- [Installing the Starter Pack Using an Org](#installing-the-starter-pack-using-an-org): This is the recommended option to begin building and deploying your own reports and dashboards.

- [Note on Sample Data Import](#note-on-sample-data-import)

- [Optional installation instructions](#optional-installation-instructions)

## Installing the Starter Pack using a Scratch Org

1. Set up your environment. Follow the steps in the [Quick Start: Lightning Web Components](https://trailhead.salesforce.com/content/learn/projects/quick-start-lightning-web-components/) Trailhead project. The steps include:

    - Enable Dev Hub in your Trailhead Playground
    - Install Salesforce CLI
    - Install Visual Studio Code
    - Install the Visual Studio Code Salesforce extensions, including the Lightning Web Components extension

1. If you haven't already done so, authorize your hub org and provide it with an alias (**myhuborg** in the command below):

    ```
    sfdx force:auth:web:login -d -a myhuborg
    ```

1. Clone this repository:

    ```
    git clone https://github.com/sercante-llc/campaign-influence-starter-pack
    cd campaign-influence-starter-pack
    ```

1. Create a scratch org and provide it with an alias (**campaigninfluence** in the command below):

    ```
    sfdx force:org:create -s -f config/project-scratch-def.json -a campaigninfluence
    ```

1. Run the scratch org setup script:

    ```
    ./setupScratchOrg.sh
    ```

1. Open the scratch org:

    ```
    sfdx force:org:open
    ```

1. In **Setup**, under **Marketing > Campaign Influence > Model Settings**, activate the **Last Touch Model** and the **Even Distribution Model**.

1. In App Launcher, select **Dashboards** and open the **Campaign Influence** dashboard.

## Installing the Starter Pack Using an Org

Follow this set of instructions if you want to deploy the app to a more permanent environment than a Scratch org.

1. Clone this repository:

    ```
    git clone https://github.com/sercante-llc/campaign-influence-starter-pack
    cd campaign-influence-starter-pack
    ```

1. Make sure Customizable Campaign Influence has been enabled in your org.
    - [Campaign Influence - Spring '20 Documentation](https://resources.docs.salesforce.com/latest/latest/en-us/sfdc/pdf/campaign_influence_implementation_guide.pdf)
    - Must have:
        - Pardot Connected
        - Enabled **Connected Campaigns**
        - Enabled **Customizable Campaign Influence** and not **Campaign Influence 1.0**
        - Enabled all additional Campaign Models

1. Authorize your Org and provide it with an alias (**mysandbox** in the command below)
    ```
    sfdx force:auth:web:login -s -a mysandbox
    ```

1. Run this command in a terminal to deploy the reports and dashboards
    ```
    sfdx force:source:deploy --manifest manifest/package.xml -l RunLocalTests
    ```
    - You may run into deployment errors with some reports referencing picklist values that do not exist. Feel free to edit the report XML file to use a picklist value that does exist in your org.
    - You may run into deployment errors if your custom APEX tests are not passing. You can get around this by deploying to a sandbox and removing the `-l RunLocalTests` part of the command.

1. In App Launcher, select Dashboards and open the **Campaign Influence** dashboard

## Note on Sample Data Import

We use the sfdx bulk upsert capabilities, which require our objects to have an external ID to facilitate the import. The custom fields in this package are ONLY to support the demo data and are NOT required to be deployed in any of your own orgs.

## Optional Installation Instructions

This repository contains several additional files to facilitate the deployment and setup of scratch orgs with demo data. If you wish to use these and deploy any of them to your sandbox or dev org, edit the package.xml file to include whatever you like.