import ballerina/grpc;
import ballerina/crypto;
import ballerina/log;
import ballerina/io;

listener grpc:Listener ep = new (9090);

map <RecordInfo> mySongs = {};

service RecordsService on ep {

    resource function writeRecord(grpc:Caller caller, RecordInfo value) {

        byte[] hash = [];
        byte[] sha = [];

        //Condition to check if song exists
        if(mySongs.hasKey(value.toString())){
            log:printError("The Song already Exists");
            string message = "The Song youre trying to enter already exists";
			error? result_ = caller->send(message);
        }else{
            mySongs[value.toString()] = <@untainted> value; //Adding the song to the map
            hash = value.toString().toBytes();
            sha = crypto:hashSha256(hash);
            io:println("Hex encoded hash with SHA256: " + sha.toBase16());
            //creates a hash code for the song being added

            error? result = caller->send(sha.toBase16()); //Checking for exception
            result = caller->complete();

            //if an exception occurs
            //check if hash code is sent successfully
            if(result is error){
                log:printError("Failed to send Hash Key due to the reason : " + result.reason().toString());
            }else{
                value.key = sha.toBase16(); //Client giving everything but the key
				io:println("================= New Records Record ===========================");
				io:println("Key Assigned : ", value.key);
				io:println("Date         : ", value.date);
				io:println("Artists      : ", value.artists);
				io:println("Band         : ", value.band);
				io:println("Songs        : ", value.songs);
            }
        }

    }
    resource function updateRecord(grpc:Caller caller, hashCode value) {
        // Implementation goes here.

        // You should return a RecordInfo
    }
    resource function viewRecord(grpc:Caller caller, hashCode value) {
        // Implementation goes here.

        // You should return a RecordInfo
    }
}

public type Songs record {|
    string title = "";
    string genre = "";
    string platform = "";
    
|};

public type Artists record {|
    string name = "";
    string member = "";
    
|};

public type RecordInfo record {|
    string key = "";
    string date = "";
    Artists[] artists = [];
    string band = "";
    Songs[] songs = [];
    
|};

public type hashCode record {|
    string key = "";
    
|};



const string ROOT_DESCRIPTOR = "0A0A737475622E70726F746F224F0A05536F6E677312140A057469746C6518012001280952057469746C6512140A0567656E7265180220012809520567656E7265121A0A08706C6174666F726D1803200128095208706C6174666F726D22350A074172746973747312120A046E616D6518012001280952046E616D6512160A066D656D62657218022001280952066D656D6265722288010A0A5265636F7264496E666F12100A036B657918012001280952036B657912120A046461746518022001280952046461746512220A076172746973747318032003280B32082E4172746973747352076172746973747312120A0462616E64180420012809520462616E64121C0A05736F6E677318052003280B32062E536F6E67735205736F6E6773221C0A0868617368436F646512100A036B657918012001280952036B65793285010A0E5265636F7264735365727669636512250A0B77726974655265636F7264120B2E5265636F7264496E666F1A092E68617368436F646512260A0C7570646174655265636F726412092E68617368436F64651A0B2E5265636F7264496E666F12240A0A766965775265636F726412092E68617368436F64651A0B2E5265636F7264496E666F620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "stub.proto":"0A0A737475622E70726F746F224F0A05536F6E677312140A057469746C6518012001280952057469746C6512140A0567656E7265180220012809520567656E7265121A0A08706C6174666F726D1803200128095208706C6174666F726D22350A074172746973747312120A046E616D6518012001280952046E616D6512160A066D656D62657218022001280952066D656D6265722288010A0A5265636F7264496E666F12100A036B657918012001280952036B657912120A046461746518022001280952046461746512220A076172746973747318032003280B32082E4172746973747352076172746973747312120A0462616E64180420012809520462616E64121C0A05736F6E677318052003280B32062E536F6E67735205736F6E6773221C0A0868617368436F646512100A036B657918012001280952036B65793285010A0E5265636F7264735365727669636512250A0B77726974655265636F7264120B2E5265636F7264496E666F1A092E68617368436F646512260A0C7570646174655265636F726412092E68617368436F64651A0B2E5265636F7264496E666F12240A0A766965775265636F726412092E68617368436F64651A0B2E5265636F7264496E666F620670726F746F33"
        
    };
}

