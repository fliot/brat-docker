# :hatching_chick: brat docker

This is a docker container deploying an instance of [brat](http://brat.nlplab.org/).


### Installation

Use the build command to create a docker image locally.

```bash
make build
```

The `brat-data` folder contains your annotation data, and the `brat-cfg` contains a file called `users.json`.
To add multiple users to the server use `users.json` to list your users and their passwords like so:

```json
{
    "user1": "password",
    "user2": "password",
    ...
}
```

The data in these directories will persist even after stopping or removing the container.

### Running

To run the container:
```bash
make run
```

You can edit the Makefile to specify local port (`-p X:80`), brat username or brat password.
