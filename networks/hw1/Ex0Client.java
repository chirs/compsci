import java.io.*;
import java.net.*;


class Ex0Client {
    public static void main(String argv[]) throws Exception
    {
	
	// Hard-coded ip address.  Please change to appropriate
	String localIP = "67.207.142.219";
	int localPort = 35601;

	// Set up some constants.
        String remoteServer = "par.cs.utexas.edu";

        String myName = "C.S.Edgemon";
        int userNum = 5000;

	String remoteIP = "128.83.120.202";
	int remotePort = 35600;

	String exNumber = "ex0";

	// Create the request string; I know, it's ugly...
	String requestIntro = exNumber + " " + remoteIP + "-" + remotePort + " " + localIP + "-" + localPort;
        String requestString =  requestIntro + " " + userNum + " " + myName + "\n";

	// Create a socket and input/output
        Socket clientSocket = new Socket(remoteServer, remotePort);

        DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());

        BufferedReader inFromServer =
            new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

	// Send the request string. 
        outToServer.writeBytes(requestString);

	// Receive the response; skip the first line.
        inFromServer.readLine(); // Empty line                                                                                                               
        String serverAck = inFromServer.readLine();

	// Parse the acknowledgment to create servernum + 1
        String[] ackArray = serverAck.split("\\s+");
        int serverNum = Integer.parseInt(ackArray[3].trim());
        int serverNumPlusOne = serverNum + 1;
        int userNumPlusOne = userNum + 1;

	// Write the acknowledment, receive the other acknowledgment, and close.
        String clientAck = "ex0 " + userNumPlusOne + " " + serverNumPlusOne + "\n"; // Manage "\n"
	outToServer.writeBytes(clientAck);
        //String serverAck2 = inFromServer.readLine();
	inFromServer.readLine();
        clientSocket.close();
    }
}

