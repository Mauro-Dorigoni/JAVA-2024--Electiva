package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import entidades.Categoria_libro;
import logic.CRUD_categoria_libro;
import java.util.LinkedList;

@WebServlet("/registerCategoria")
@MultipartConfig
public class RegisterCategoriaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Part filePart = request.getPart("imagen"); 


        String fileName = request.getParameter("nombre") + ".jpg"; 


        String relativePath = "assets/categorias/";
        String savePath = getServletContext().getRealPath(relativePath) + File.separator + fileName;

        File fileSaveDir = new File(getServletContext().getRealPath(relativePath));
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }

        try (InputStream inputStream = filePart.getInputStream();
             FileOutputStream outputStream = new FileOutputStream(savePath)) {

            int read;
            final byte[] bytes = new byte[1024];
            while ((read = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        }


        Categoria_libro c = new Categoria_libro();
        c.setNombre_categoria(request.getParameter("nombre"));
        c.setDescripcion_apliada(request.getParameter("descripcion"));


        CRUD_categoria_libro cl = new CRUD_categoria_libro();
        LinkedList<Categoria_libro> cats = cl.getByDatos(c);

        if (cats.isEmpty()) {
            cl.save(c);
            request.setAttribute("messageType", "success");
            request.setAttribute("message", "Categoría registrada con éxito.");
        } else {
            request.setAttribute("messageType", "error");
            request.setAttribute("message", "Categoría ya registrada.");
        }


        request.getRequestDispatcher("altaCategoria.jsp").forward(request, response);
    }
}