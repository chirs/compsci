import java.io.*;
import java.net.*;


class Remote2 {
    public static void main(String argv[]) throws Exception
    {

        ServerSocket welcomeSocket = new ServerSocket(35601);
	while (true) {
        Socket connectionSocket = welcomeSocket.accept();

        BufferedReader inFromClient =
            new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
        DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());

	String clientSentence = inFromClient.readLine();
	System.out.println(clientSentence);
	}

    }
}
