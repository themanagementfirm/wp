# tmf-wordpress

Docker container for an out of the box fully managed Wordpress instance. Includes over 100+ of the world's most popular plugins installed, activated, and ready to maximized efficency with high impact in any market immediately.

## Using this docker image

To deploy an instance locally, open terminal and run the following:

  ```
  git clone https://github.com/themanagementfirm/wp
  cd wp
  docker build -t <your-company-name>/<your-wordpress-site-name>:latest .
  docker compose up
  ```

Ensure you replace `<your-company-name>` with the name of your company and `<your-wordpress-site-name>` with the name of the website being deployed. Do note, `<your-company-name>` should be the company's profile name at [hub.docker.com](https://hub.docker.com)

## How to contribute

Contributing to any resource on The Management Firm can be done as so:

  1. Clone this repository ``` git clone https://github.com/themanagementfirm/wordpress ```
  2. Create a new branch for your updates ``` git checkout -b your-new-branch-name-should-replace-this```
  3. Make your updates
  4. Add and commit your updates to the branch ``` git add . \ git commit -a -m "fix: updated something" ```
  5. Push your changes ``` git push ```
  6. If this is a new branch you'll be prompted to set remote upstream for branch go ahead and do so ``` git push --set-upstream origin your-new-branch-name-should-replace-this ```
  7. Create a pull request against master
  8. Make sure to swap back to master branch once all edits are submitted ``` git checkout master ```
  9. Your code will be checked and approved by a verified user inside of the OWNERS file.

## Issues


Post issues at: https://github.com/themanagementfirm/wp/issues
