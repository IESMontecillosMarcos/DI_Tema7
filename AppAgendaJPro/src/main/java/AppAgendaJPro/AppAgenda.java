/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AppAgendaJPro;

import AppAgendaJPro.Provincia;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Marcos GOnzalez Leon
 */
public class AppAgenda {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("AppHotelPU");
        EntityManager em = emf.createEntityManager();
        
        // em.getTransaction().begin();
        // em.getTransaction().commit();
        // em.getTransaction().rollback();
        
        // Creamos Objetos.
        Provincia provinciaCadiz = new Provincia();
        provinciaCadiz.setNombre("Cadiz");
        em.getTransaction().begin();
        em.persist(provinciaCadiz);
        em.getTransaction().commit();
        
        Provincia provinciaSevilla = new Provincia();
        provinciaSevilla.setNombre("Sevilla");
        em.getTransaction().begin();
        em.persist(provinciaSevilla);
        em.getTransaction().commit();
        
        em.close();
        emf.close();
        
        try{
            DriverManager.getConnection("jdbc:hsqldb:hsql:xdb;shutdown=true");
        } catch (SQLException ex){}
    }
    
}
