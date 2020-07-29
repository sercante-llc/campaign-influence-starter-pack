# Campaign Influence Starter Pack

This Starter Pack was developed for professionals who have already set up Connected Campaigns and Campaign Influence, and now want to understand what kind of reporting is available to them. If you need help with the setup, someone to bounce questions off of, or just a second set of eyes, you’re in luck: Sercante has helped many companies through Connected Campaigns & Campaign Influence Reporting. [Let's Chat >](https://www.sercante.com/contact-us/)

> This sample application is designed to run on Salesforce Platform. 

> This package is designed to both run independently (in a self contained scratch org) as well as be directly deployed to an existing org (Sandbox or Production).


## Table of contents

- [Installing the Starter Pack Using a Scratch Org](#installing-the-starter-pack-using-a-scratch-org): This is the recommended option to explore the reports and dashboards.

- [Installing the Starter Pack Using an Org](#installing-the-starter-pack-using-an-org): This is the recommended option to begin building and deploying your own reports and dashboards.

- [Note on Sample Data Import](#note-on-sample-data-import)

- [Optional installation instructions](#optional-installation-instructions)

## Installing the Starter Pack using a Scratch Org

1. Set up your environment. The steps include:

    - Enable Dev Hub in your org
    - [Install Salesforce CLI](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm)

1. If you haven't already done so, authorize your hub org and provide it with an alias (**myhuborg** in the command below):

    ```
    sfdx force:auth:web:login -d -a myhuborg
    ```

1. Clone this repository, [or download a zip file](https://github.com/sercante-llc/campaign-influence-starter-pack/archive/master.zip):

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

1. Clone this repository, [or download a zip file](https://github.com/sercante-llc/campaign-influence-starter-pack/archive/master.zip):

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

1. Setup your environment
    - [Install Salesforce CLI](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm)

1. Make sure the user you are deploying with has all the right permissions
    - **Campaign Influence** - This was setup in a permission set when Customizable Campaign Influence was set up
    - **Change Dashboard Colors** - This permission is needed in Lightning to deploy dasbhoards
    - **Create and Customize Dashboards**
    - **Create Dashboard Folders**
    - **Create and Customize Reports**
    - **Create Report Folders**

1. Authorize your Salesforce org and provide it with an alias (**cisporg** in the commands below)
    ```
    # likely the command that will work for you
    sfdx force:auth:web:login -s -a cisporg
    # if you are using a sandbox, use this:
    sfdx force:auth:web:login -s -a cisporg -r https://test.salesforce.com
    # if you want to specify a company specific login URL, use this command
    sfdx force:auth:web:login -s -a cisporg -r https://mycompanyloginurl.my.salesforce.com
    ```

1. Run this command in a terminal to deploy the reports and dashboards
    ```
    sfdx force:source:deploy --manifest manifest/package.xml -l RunLocalTests -u cisporg
    # if you have APEX tests that are failing (and at least 1 that passes) run the following command (replacing the name of the test)
    sfdx force:source:deploy --manifest manifest/package.xml --testlevel RunSpecifiedTests -r NameOfAnyTestThatPassesHere -u cisporg
    ```

1. In App Launcher, select Dashboards and open the **Campaign Influence** dashboard

## Note on Sample Data Import

We use the sfdx bulk upsert capabilities, which require our objects to have an external ID to facilitate the import. The custom fields in this package are ONLY to support the demo data and are NOT required to be deployed in any of your own orgs.

## Optional Installation Instructions

This repository contains several additional files to facilitate the deployment and setup of scratch orgs with demo data. If you wish to use these and deploy any of them to your sandbox or dev org, edit the package.xml file to include whatever you like.