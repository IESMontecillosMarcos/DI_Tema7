/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AppAgendaJPro;

import AppAgendaJPro.Persona;
import AppAgendaJPro.Provincia;
import java.io.IOException;
import java.net.URL;
import java.util.List;
import java.util.Optional;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonType;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TablePosition;
import javafx.scene.control.TableView;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.StackPane;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * FXML Controller class
 *
 * @author Marcos GOnzalez Leon
 */
public class AgendaViewController implements Initializable {

    // Acceso del controlador mediante objeto de clase.
    private EntityManager entityManager;
    @FXML
    private TableView<Persona> tableViewAgenda;
    @FXML
    private TableColumn<Persona, String> columnNombre;
    @FXML
    private TableColumn<Persona, String> columnApellidos;
    @FXML
    private TableColumn<Persona, String> columnEmail;
    @FXML
    private TableColumn<Persona, String> columnProvincia;
    @FXML
    private TextArea textFieldNombre;
    @FXML
    private TextField textFieldApellidos;
    
    private Persona personaSeleccionada;
    @FXML
    private AnchorPane rootAgendaView;
    
    /**
     * Initializes the controller class.
     * @param url
     * @param rb
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {        
        // Indicar que propiedad de clase Persona se mostrara en la columna columnNombre.
        columnNombre.setCellValueFactory(new PropertyValueFactory<>("nombre"));
        columnApellidos.setCellValueFactory(new PropertyValueFactory<>("apellidos"));
        columnEmail.setCellValueFactory(new PropertyValueFactory<>("email"));
        
        // Comprobar por cada ID en la tabla, si existe elemento Provincia.
        columnProvincia.setCellValueFactory(cellData->{
            SimpleStringProperty property = new SimpleStringProperty();
            if (cellData.getValue().getProvincia()!=null){
                property.setValue(cellData.getValue().getProvincia().getNombre());
            }
            return property;
        });
        
        
        tableViewAgenda.getSelectionModel().selectedItemProperty().addListener(
        (observable,oldValue,newValue)->{personaSeleccionada=newValue;
        
        if (personaSeleccionada != null){
            textFieldNombre.setText(personaSeleccionada.getNombre());
            textFieldApellidos.setText(personaSeleccionada.getApellidos());
        } else {
            textFieldNombre.setText("");
            textFieldApellidos.setText("");
        }
        });
    }   
    
    public void setEntityManager(EntityManager entityManager){
        this.entityManager=entityManager;
    }
    
    public void cargarTodasPersonas(){
        Query queryPersonaFindAll = entityManager.createNamedQuery("Persona.findAll");
        List<Persona> listPersona = queryPersonaFindAll.getResultList();
        tableViewAgenda.setItems(FXCollections.observableArrayList(listPersona));
    }

    @FXML
    private void onActionButtonGuardar(ActionEvent event) {
                
        // Comprobar que hay una fila seleccionada.
        if (personaSeleccionada != null){
            // Recoger valores del campo.
            personaSeleccionada.setNombre(textFieldNombre.getText());
            personaSeleccionada.setApellidos(textFieldApellidos.getText());
            
            // Edicion de datos.
            entityManager.getTransaction().begin();
            entityManager.merge(personaSeleccionada);
            entityManager.getTransaction().commit();
            
            // Actualizar valor de fila.
            int numFilaSeleccionada = tableViewAgenda.getSelectionModel().getSelectedIndex();
            tableViewAgenda.getItems().set(numFilaSeleccionada,personaSeleccionada);

            // Devolver el Foco de seleccion.
            TablePosition pos = new TablePosition(tableViewAgenda,numFilaSeleccionada,null);
            tableViewAgenda.getFocusModel().focus(pos);
            tableViewAgenda.requestFocus();
        }
    }

    @FXML
    private void onActionButtonNuevo(ActionEvent event) {
         try {
            // Cargar la vista de detalle
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("/fxml/PersonaDetalleView.fxml"));
            Parent rootDetalleView = fxmlLoader.load();
            PersonaDetalleViewController personaDetalleViewController = (PersonaDetalleViewController) fxmlLoader.getController();
            personaDetalleViewController.setRootAgendaView(rootAgendaView);

            // Ocultar la vista de la lista
            rootAgendaView.setVisible(false);

            //A??adir la vista detalle al StackPane principal para que se muestre
            StackPane rootMain = (StackPane) rootAgendaView.getScene().getRoot();
            rootMain.getChildren().add(rootDetalleView);

            personaDetalleViewController.setTableViewPrevio(tableViewAgenda);

            personaSeleccionada = new Persona();
            personaDetalleViewController.setPersona(entityManager, personaSeleccionada, true);
            personaDetalleViewController.setEntityManager(entityManager);

            // Mostramos Datos
            personaDetalleViewController.mostrarDatos();

        } catch (IOException ex) {
            Logger.getLogger(AgendaViewController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @FXML
    private void onActionButtonEditar(ActionEvent event) {
        
        try{
            // Cargar la vista de detalle
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("/fxml/PersonaDetalleView.fxml"));
            Parent rootDetalleView = fxmlLoader.load();
            
            PersonaDetalleViewController personaDetalleViewController =
            (PersonaDetalleViewController) fxmlLoader.getController();
            personaDetalleViewController.setRootAgendaView(rootAgendaView);

            //Intercambio de datos funcionales con el detalle
            personaDetalleViewController.setTableViewPrevio(tableViewAgenda);
            // Para el bot??n Editar
            personaDetalleViewController.setPersona(entityManager,
            personaSeleccionada,false);

            // Ocultar la vista de la lista
            rootAgendaView.setVisible(false);
            
            personaDetalleViewController.mostrarDatos();
            
             //A??adir la vista detalle al StackPane principal para que se muestre
            StackPane rootMain = (StackPane) rootAgendaView.getScene().getRoot();
            rootMain.getChildren().add(rootDetalleView);
            } catch (IOException ex){
            Logger.getLogger(AgendaViewController.class.getName()).log(Level.SEVERE,null,ex);
        }
    }

    @FXML
    private void onActionButtonSuprimir(ActionEvent event) {
        Alert alert = new Alert(AlertType.CONFIRMATION);
        alert.setTitle("Confirmar");
        alert.setHeaderText("??Desea suprimir el siguiente registro?");
        alert.setContentText(personaSeleccionada.getNombre() + " "
         + personaSeleccionada.getApellidos());
        Optional<ButtonType> result = alert.showAndWait();
        
        if (result.get() == ButtonType.OK){
            // Acciones a realizar si el usuario acepta
            entityManager.getTransaction().begin();
            entityManager.merge(personaSeleccionada);
            entityManager.remove(personaSeleccionada);
            entityManager.getTransaction().commit();
            tableViewAgenda.getItems().remove(personaSeleccionada);
            tableViewAgenda.getFocusModel().focus(null);
            tableViewAgenda.requestFocus();
        } else {
            // Acciones a realizar si el usuario cancela
            int numFilaSeleccionada=
            tableViewAgenda.getSelectionModel().getSelectedIndex();
            tableViewAgenda.getItems().set(numFilaSeleccionada,personaSeleccionada);
            TablePosition pos = new TablePosition(tableViewAgenda,
            numFilaSeleccionada,null);
            tableViewAgenda.getFocusModel().focus(pos);
            tableViewAgenda.requestFocus();
        }
    }
    
}
