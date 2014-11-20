import java.io.*;
import java.net.*;


class Remote {
    public static void main(String argv[]) throws Exception
    {
	
	(int h = 5;)

        String remoteServer = "par.cs.utexas.edu";

        String myName = "C.S.Edgemon";
        int userNum = 5000;

	String remoteIP = "128.83.120.202";
	int remotePort = 35600;

	String localIP = "67.207.142.219";
	int localPort = 35601;

	String exNumber = "ex1";

	String requestIntro = exNumber + " " + remoteIP + "-" + remotePort + " " + localIP + "-" + localPort;
        String requestString =  requestIntro + " " + userNum + " " + myName + "\n";

        System.out.println(requestString);

	Socket clientSocket = new Socket(remoteServer, remotePort);
        ServerSocket welcomeSocket = new ServerSocket(localPort);

        DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());
        BufferedReader inFromServer =
            new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

        outToServer.writeBytes(requestString);

        //inFromServer.readLine(); // Empty line
        //String serverAck = inFromServer.readLine();
        //System.out.println(serverAck);

        Socket connectionSocket = welcomeSocket.accept();

        BufferedReader inFromServer2 =
            new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
	
	String serverAck2 = inFromServer2.readLine();

	clientSocket.close();
	welcomeSocket.close();

	System.out.println(serverAck2);




    }
}
