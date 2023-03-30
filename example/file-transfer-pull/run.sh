curl -X POST http://localhost:19193/api/v1/data/instances -H 'Content-Type: application/json' -d '{
   "edctype": "dataspaceconnector:dataplaneinstance",
   "id": "http-pull-provider-dataplane",
   "url": "http://localhost:19192/control/transfer",
   "allowedSourceTypes": [ "HttpData", "IonosS3" ],
   "allowedDestTypes": [ "HttpProxy", "HttpData"],
   "properties": {
     "publicApiUrl": "http://localhost:19291/public/"
   }
 }' 
curl  -X POST http://localhost:29193/api/v1/data/instances  -H 'Content-Type: application/json' -d '{
   "edctype": "dataspaceconnector:dataplaneinstance",
   "id": "http-pull-consumer-dataplane",
   "url": "http://localhost:29192/control/transfer",
   "allowedSourceTypes": [ "HttpData" ],
   "allowedDestTypes": [ "HttpProxy", "HttpData", "IonosS3" ],
   "properties": {
     "publicApiUrl": "http://localhost:29291/public/"
   }
 }' 
curl -H 'content-type: application/json' http://localhost:19193/api/v1/data/assets -d '{
           "asset": {
             "properties": {
               "asset:prop:id": "assetId",
               "asset:prop:name": "product description",
               "asset:prop:contenttype": "application/json"
             }
           },
           "dataAddress": {
             "properties": {
               "name": "device1-data.csv",
			   "bucketName": "pullcompany2",
               "container": "pullcompany2",
               "blobName": "device1-data.csv",
               "storage": "s3-eu-central-1.ionoscloud.com",
               "type": "IonosS3"
             }
           }
         }' 
curl -H 'content-type: application/json' http://localhost:19193/api/v1/data/policydefinitions -d '{
           "id": "aPolicy",
           "policy": {
             "uid": "231802-bb34-11ec-8422-0242ac120002",
             "permissions": [
               {
                 "target": "assetId",
                 "action": {
                   "type": "USE"
                 },
                 "edctype": "dataspaceconnector:permission"
               }
             ],
             "type": {
               "policytype": "set"
             }
           }
         }'
curl -H 'content-type: application/json' http://localhost:19193/api/v1/data/contractdefinitions -d '{
           "id": "1",
           "accessPolicyId": "aPolicy",
           "contractPolicyId": "aPolicy",
           "criteria": []
         }' 		
curl -X POST http://localhost:29193/api/v1/data/catalog/request --header 'Content-Type: application/json'--data-raw '{
  "providerUrl": "http://localhost:19194/api/v1/ids/data"
}'

curl -X POST -H 'content-type: application/json' http://localhost:29193/api/v1/data/contractnegotiations -d '{
           "connectorId": "http-pull-provider",
           "connectorAddress": "http://localhost:19194/api/v1/ids/data",
           "protocol": "ids-multipart",
           "offer": {
             "offerId": "1:50f75a7a-5f81-4764-b2f9-ac258c3628e2",
             "assetId": "assetId",
             "policy": {
               "uid": "231802-bb34-11ec-8422-0242ac120002",
               "permissions": [
                 {
                   "target": "assetId",
                   "action": {
                     "type": "USE"
                   },
                   "edctype": "dataspaceconnector:permission"
                 }
               ],
               "type": {
                 "policytype": "set"
               }
             }
           }
         }' 	 