# Multi-Site Example using Docker and Apache

This is a multi-site setup using Docker, Apache, and PHP to host multiple websites on a single server.

## Prerequisites

- **Docker**
- **Local Host Configuration**
  ```
  127.0.0.1 a1.example.com
  127.0.0.1 a2.example.com
  ```

## Getting Started

1. **Clone Repository:**

    ```
    git clone --recursive https://github.com/ViralOne/Dockerized-Apache-MultiSite.git
    ```

    Note: This repository uses submodules. Include the `--recursive` flag to clone all necessary submodules.

2. **Build Docker Container:**

    ```bash
    docker build -t multisite-apache .
    ```

3. **Run Docker Container:**

    ```bash
    docker run -d -p 80:80 multisite-apache
    ```

    Replace `multisite-apache` with the name of the Docker image.

4. **Access Sites:**

    Open your browser and navigate to:
    - [http://a1.example.com](http://a1.example.com)
    - [http://a2.example.com](http://a2.example.com)

## Folder Structure

- `configs/` - Contains Apache site configuration files.
- `site-1/` - Files for the first website (`a1.example.com`).
- `site-2/` - Files for the second website (`a2.example.com`).
- `init.sh` - Initialization script for setting up Apache and configuring virtual hosts.

## Customization

- To add more sites:
    1. Create a new directory similar to `site-1` and `site-2`.
    2. Add a new Apache configuration file and place it in the `configs/` directory.
    3. Update the hosts file and the Dockerfile accordingly.

### Notes

- **Git Submodules:**
  - Use `git submodule update --init` to initialize all specified submodules & fetch their contents.
  - Use `git submodule add <REPO> <DIRECTORY>` to add a new submodule.
- **External Repositories Used:**
  - [aeimskei/basic-php-website](https://github.com/aeimskei/basic-php-website) by user [aeimskei](https://github.com/aeimskei)
  - [AmaliaMinzat/Bookstore_project_Bookly](https://github.com/AmaliaMinzat/Bookstore_project_Bookly) by user [AmaliaMinzat](https://github.com/AmaliaMinzat)
