# AWS Login
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region ap-southeast-2

# Build image
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS
docker build -t smithjw/eve-bot:$BUILDKITE_COMMIT .

# Run container with specs
docker run -e HUBOT_SLACK_TOKEN=xoxb-8345717250-bIGoEGLsytrKRrDnMY0aiYj2 -d smithjw/eve-bot:$BUILDKITE_COMMIT

# Tag image with current branch name and push when specs are green
docker tag -f smithjw/eve-bot:$BUILDKITE_COMMIT smithjw/eve-bot:$BUILDKITE_BRANCH
docker push smithjw/eve-bot:$BUILDKITE_BRANCH

# Testing
