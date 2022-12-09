#!/bin/bash

ip addr
echo ref_ip is "${ref_ip}"

echo "Starting SDCri provider"
(cd ri && sleep 999999999 | mvn -Pprovider exec:java) &
sleep 30
echo "Starting sdc11073 consumer"
python3 -m unittest sdc11073.examples.ReferenceTest.test_reference.Test_Reference.test_client_connects
test_exit_code=$?

echo "Terminating SDCri provider"
jobs && kill %1

exit "$test_exit_code"