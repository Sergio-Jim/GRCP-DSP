import ballerina/grpc;

public type RecordsServiceBlockingClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function __init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "blocking", ROOT_DESCRIPTOR, getDescriptorMap());
    }

    public remote function writeRecord(RecordInfo req, grpc:Headers? headers = ()) returns ([hashCode, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("RecordsService/writeRecord", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<hashCode>result, resHeaders];
        
    }

    public remote function updateRecord(hashCode req, grpc:Headers? headers = ()) returns ([RecordInfo, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("RecordsService/updateRecord", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<RecordInfo>result, resHeaders];
        
    }

    public remote function viewRecord(hashCode req, grpc:Headers? headers = ()) returns ([RecordInfo, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("RecordsService/viewRecord", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<RecordInfo>result, resHeaders];
        
    }

};

public type RecordsServiceClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function __init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "non-blocking", ROOT_DESCRIPTOR, getDescriptorMap());
    }

    public remote function writeRecord(RecordInfo req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("RecordsService/writeRecord", req, msgListener, headers);
    }

    public remote function updateRecord(hashCode req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("RecordsService/updateRecord", req, msgListener, headers);
    }

    public remote function viewRecord(hashCode req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("RecordsService/viewRecord", req, msgListener, headers);
    }

};

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

