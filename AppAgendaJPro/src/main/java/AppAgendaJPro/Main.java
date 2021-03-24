/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AppAgendaJPro;

import com.jpro.webapi.JProApplication;
import java.net.URL;
import java.sql.DriverManager;
import java.sql.SQLException;
import static javafx.application.Application.launch;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.Pane;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Marcos Gonzalez Leon
 */
public class Main extends JProApplication {

    private EntityManagerFactory emf;
    private EntityManager em;

    @Override
    public void start(Stage primaryStage) throws Exception {
        StackPane rootMain = new StackPane();
        //URL myFxmlURL = ClassLoader.getSystemResource("/fxml/AgendaView.fxml");
        //FXMLLoader loader = new FXMLLoader(myFxmlURL);
        //Pane rootAgendaView = loader.load();
        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("/fxml/AgendaView.fxml"));
        Pane rootAgendaView = fxmlLoader.load();        
        rootMain.getChildren().add(rootAgendaView);

        emf = Persistence.createEntityManagerFactory("AppAgendaPU");
        em = emf.createEntityManager();
        
        
        //Carga del EntityManager, etc…
        //AgendaViewController agendaViewController = (AgendaViewController) loader.getController();
        AgendaViewController agendaViewController = (AgendaViewController) fxmlLoader.getController();
        agendaViewController.setEntityManager(em);
        agendaViewController.cargarTodasPersonas();

        Scene scene = new Scene(rootMain, 600, 400);
        primaryStage.setTitle("App Agenda");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
    
    @Override
    public void stop() throws Exception {
        em.close();
        emf.close();
        try {
            DriverManager.getConnection("jdbc:hsqldb:hsql://localhost:9001/BDAgenda");
        } catch (SQLException ex) {
        }
    }

    public static void main(String[] args) {
        launch(args);
    }
}
