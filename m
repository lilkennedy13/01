package ru.daa.demo1.controller;

import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import ru.daa.demo1.model.Employee;
import ru.daa.demo1.model.Manager;

import javafx.event.ActionEvent;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.util.Optional;
import java.util.ResourceBundle;

import static ru.daa.demo1.util.Mgr.dataList;
import static ru.daa.demo1.util.Mgr.showConfirmPopup;

public class MainController implements Initializable {

    @FXML
    private TableView<Employee> ViewSale;

    @FXML
    private Button delete;

    @FXML
    private TableColumn<Employee, String> tableName;

    @FXML
    private TableColumn<Employee, Number> tableSale;

    @FXML
     void ddd(ActionEvent event) {
        Employee employee=ViewSale.getSelectionModel().getSelectedItem();
        if(employee==null)
            return;
        Optional<ButtonType> result=showConfirmPopup();
        if(result.get()==ButtonType.OK){
            dataList.remove(employee);
            loadTableView();
        }

    }


    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        loadData();
        loadTableView();
        setCellValueFactories();
    }

    private void setCellValueFactories() {
        tableSale.setCellValueFactory(i->new SimpleDoubleProperty(i.getValue().getS()));
        tableName.setCellValueFactory(i->new SimpleStringProperty(i.getValue().getName()));
    }

    private void loadTableView() {
        ViewSale.getItems().clear();
        for(Employee i:dataList){
            ViewSale.getItems().add(i);
        }

    }

    private void loadData() {
        int count=0;
        try{
            BufferedReader br=new BufferedReader(new FileReader("C:\\Users\\staro\\IdeaProjects\\demo\\2.txt"));
            String line;
            while((line =br.readLine())!=null){
                String[]words=line.split(";",0);
                dataList.add(new Manager(Double.parseDouble(words[0]), words[1]));
                count=count+1;
            }
            Alert alert=new Alert(Alert.AlertType.INFORMATION);
            alert.setTitle("Считано");
            alert.setHeaderText(null);
            alert.setContentText(" "+count);
            alert.showAndWait();
        }
        catch (IOException e) {
            e.printStackTrace();

        }
    }

}

