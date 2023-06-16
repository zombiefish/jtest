### Building the new release base containers

#### History

| Date | Release | Who | Comment |
| -- | -- | -- | -- |
| 27-07-2022 | 1.3.1.1 | Andy Prowse | Migration to universal containers for all, ConfigMaps in baseclient |

#### Instructions

In this example, we will build the 1.3.1.1 release containers

1.  Cloning the Infra-Rancher/baseImages repsitory locally

    If you do not have it already, grab the baseIamge code

    ```sh
    git clone ssh://git@bitbucket.sofvie.com:7999/inra/baseimages.git
    ```

1.  Update to the latest master branch

    Ensure you are on master, and it is fresh

    ```sh
    git checkout master
    git pull
    ```

1.  Create a new branch for this release

    Create a new branch.  This step is very important is it does two things:

    1. Allows for easy tracking of the branch for back-porting of issues, consistency
    1. branch name is used for configuration

    The format for the branch is as follows:

    **VERSION**  such as **1.3.1.1.*

    ```sh
    git checkout -b 1.3.1.1
    ```

    We are now in the new branch ready to build our images.

    In this directory there are two sub-directories, and three files.

    - README.md - information about baseImages
    - docker/ - Dockerfiles and data files for the creation of the base images
    - buildImages - shell script to build the base container images
    - seedCode - shell script to seed code to the docker data files required for the base images

1.  seedCode

    There is one line in seedCode that needs to be edited, the path to your local copy of the SofvieCore project repositories

    Edit `SRC` to point to the project base directory

    ```sh
    SRC=/home/aprowse/Projects/Clients/Sofvie/sofvie/source/sofvieCore
    ```

    The shell script will use the branch name as Sofvie release

    - VER - being the release version, in this case 1.1.4

    The script then takes this information, and traverses the SofvieCore repositories building a tar file of the compenents, and seeding the docker directory with the contents

    Next, it takes the configuration files, and places them in the correct service

1.  baseImages

    Next, we go to the `baseImages` shell script to build out the images to be customised for each client. Below are the major steps the script does:

    We again reference the branch for version and environment

    The `baseImage` script grabs the public domain, but validated docker hub images through the Sofvie caching nexus repository as a base image for the Sofvie base image.

    Next, we add a label to each docker image with the version and environment information

    This is followed by the base image creation.  This is the most time consuming part, as the source code is integrated into the base containers, and modifications are made to the source code for proper kubernetes functionality.

    Once the images are created, they are tagged in a methodical, and comprehensive manner to allow for easy identification of their role in the client onboarding process. At this point they are pushed to the secure Sofvie nexus repository.

    **Images created:**

    The images created are

    - repo.sofvie.com:5000/1.3.1.1:api-1
    - repo.sofvie.com:5000/1.3.1.1:app-1
    - repo.sofvie.com:5001/1.3.1.1:couchdb-1
    - repo.sofvie.com:5000/1.3.1.1:mariadb-1
    - repo.sofvie.com:5000/1.3.1.1:mobile-1
    - repo.sofvie.com:5000/1.3.1.1:sqllistener-1
    - repo.sofvie.com:5000/1.3.1.1:reports-app-1
    - repo.sofvie.com:5000/1.3.1.1:resources-1

#### Updates

The script `updateImage`, located in docker/[SERVICE] will create a new image, such as 1.3.1.1:api-2 when there is an update to the release code.  This iimage will then need to be applied to the approriate service manifest for each namespace


