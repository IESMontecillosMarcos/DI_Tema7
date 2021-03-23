/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AppAgendaJPro;

import AppAgendaJPro.Provincia;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author Marcos Gonzalez Leon
 */
public class ConsultaProvincias {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {        
        
        
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("AppAgendaPU");
        EntityManager em = emf.createEntityManager();
        
        Query queryProvincias = em.createNamedQuery("Provincia.findAll");
        
        // LISTAR TODAS LAS PROVINCIAS.
        List<Provincia> listProvincias = queryProvincias.getResultList();

        for(int i=0;i<listProvincias.size();i++){
            Provincia provincia=listProvincias.get(i);
            System.out.println(provincia.getNombre());
        }
        
        
        // LISTAR CADIZ.
        Query queryProvinciaCadiz = em.createNamedQuery("Provincia.findByNombre");
        queryProvinciaCadiz.setParameter("nombre", "Cadiz");
        List<Provincia> listProvinciasCadiz =queryProvinciaCadiz.getResultList();
        
        em.getTransaction().begin();
        
        for(Provincia provinciaCadiz : listProvinciasCadiz){
            provinciaCadiz.setCodigo("CA");
            em.merge(provinciaCadiz);
        }
        em.getTransaction().commit();

        em.close();
        emf.close();
    }
    
}
