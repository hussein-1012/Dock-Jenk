FROM node:18

# Set the working directory
WORKDIR /app  

# Copy package.json and install dependencies based on the environment
COPY package.json .

ARG NODE_ENV
RUN if [ "$NODE_ENV" = "production" ];\
    then npm install --only=production;\
    else npm install;\
    fi

# Copy all files into the container
COPY . .

# Copy the JAR file into the container
COPY target/demo1-0.0.1-SNAPSHOT.jar /app/demo1-0.0.1-SNAPSHOT.jar

# Expose the application port
EXPOSE 4000

# Run both the Node.js and Java applications together
CMD ["sh", "-c", "npm run start-dev & java -jar demo1-0.0.1-SNAPSHOT.jar"]
