#!/bin/sh

echo "> run deploy.sh" >> /home/ec2-user/workspace/deploy.log

if [ -d /home/ec2-user/tmp/node_modules ]
then
  rm -rf /home/ec2-user/tmp/node_modules
  rm -rf /home/ec2-user/tmp/yarn.lock
  rm -rf /home/ec2-user/tmp/package.json
fi

cd /home/ec2-user/tmp/
yarn

if [ -d /home/ec2-user/workspace/node_modules ]
then
  rm -rf /home/ec2-user/workspace/node_modules
  rm -rf /home/ec2-user/workspace/package.json
  rm -rf /home/ec2-user/workspace/public
fi

mv /home/ec2-user/tmp/node_modules /home/ec2-user/workspace/node_modules
mv /home/ec2-user/tmp/package.json /home/ec2-user/workspace/package.json
mv /home/ec2-user/tmp/public /home/ec2-user/workspace/public
cp -r /home/ec2-user/tmp/.next /home/ec2-user/workspace/

pm2 reload next

rm -rf /home/ec2-user/tmp/* /home/ec2-user/tmp/.next
