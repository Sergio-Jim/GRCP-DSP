import ballerina/io;
import ballerina/grpc;

public function main (string mode) returns error? {

    RecordsServiceBlockingClient blockingEp = new("http://localhost:9090");

    if (mode == "addSong") {
        RecordInfo info = {
                date: "22/10/2020",
                artists: [
                    {
                    name: "Winston Marshall",
                    member: "yes"
                    },
                    {
                    name: "Ben Lovett",
                    member: "yes"
                    },
                    {
                    name: "Baaba Maal",
                    member: "no"
                    }
                ],
                band: "Mumford & Sons",
                songs: [
                    {
                        title: "There will be time",
                        genre: "folk rock",
                        platform: "Deezer"
                    }
                ]
            };

            [hashCode, grpc:Headers] result = check blockingEp->writeRecord(info);
            io:println("A record has Successfully been added");
			io:println("HASH KEY : ",result);

    } else if (mode == "updateSong") {
    } else if (mode == "viewSong") {
    } else {
        io:println("Unsupported operation mode entered!");
        return;
    }

    
}


