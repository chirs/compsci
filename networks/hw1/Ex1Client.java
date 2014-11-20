import java.io.*;
import java.net.*;


class Ex1Client {
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

	String exNumber = "ex1";

	// Create the request string; I know, it's ugly...
	String requestIntro = exNumber + " " + remoteIP + "-" + remotePort + " " + localIP + "-" + localPort;
        String requestString =  requestIntro + " " + userNum + " " + myName + "\n";

	// Create both sockets
	Socket clientSocket = new Socket(remoteServer, remotePort);
        ServerSocket welcomeSocket = new ServerSocket(localPort);

	// Create input and output for the client socket.
        DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());
        BufferedReader inFromServer =
            new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

	// Send the request string. 
        outToServer.writeBytes(requestString);

	// Receive line from the server and parse it to return servernum + 1
        inFromServer.readLine(); // Empty line
        String serverAck = inFromServer.readLine();
        String[] ackArray = serverAck.split("\\s+");
        int serverNum = Integer.parseInt(ackArray[3].trim());
        int serverNumPlusOne = serverNum + 1;

	// Begin blocking on the server socket.
        Socket connectionSocket = welcomeSocket.accept();

	// Create input and output for the server socket.
        BufferedReader inFromClient =
            new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
        DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());

	// Read input to the server socket.  Parse the newservernum so we can return newservernum + 1	
	String clientAck = inFromClient.readLine();
	String clientNum = clientAck.trim().split("\\s+")[4];
	int clientNumPlusOne = Integer.parseInt(clientNum) + 1;

	// Print this line
	System.out.println("CS 356 server sent " + clientNum + "\n");

	// Return the requested string
	String clientString = serverNumPlusOne + " " + clientNumPlusOne + "\n";
	outToClient.writeBytes(clientString);
	
	// Close the sockets
	clientSocket.close();
	welcomeSocket.close();






    }
}
