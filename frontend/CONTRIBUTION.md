# Contributing to the Frontend of Language Crowdsource Project

To contribute, follow these steps:

1. **Clone the Repository**: Clone the forked repository to your local machine using the following command:

   ```bash
   git clone https://github.com/your-username/project-name.git
   ```

2. **Create a branch**: Create a new branch for your contribution

```
    git checkout -b your-feature-name
```

3. **Make Changes**: Make the desired changes to the project

4. **Update Docker Image**: Rebuild the docker image and run it to check your changes.
Run the _contribute.sh_ script

```
    bash contribute.sh -a <tag> <port>
```

Where:

_tag_  - the image version tag
_port_ - the tcp port the application runs on

For more information on how to use the _contribute.sh_ script, run the command:

```
    bash contribute.sh -h
```

5. **Commit Changes**: Sign and Commit your changes with a brief commit message

```
    git add <file_name>
    git commit -S -m "Brief description of changes made"
```

4. **Push Changes**: Push your changes to your branch

```
    git push origin your-feature-name
```

5. **Open a Pull Request**: Visit the repository on github and create a new pull request.
Provide a clear title and description of your changes.

6. **Wait for review:** Do not merge your own pull requests!