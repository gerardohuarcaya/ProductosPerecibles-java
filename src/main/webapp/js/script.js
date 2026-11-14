/*
 * JavaScript compartido del sistema Productos Perecibles.
 * Este archivo se carga desde todas las páginas JSP.
 */

document.addEventListener("DOMContentLoaded", function () {

    // 1. Marcar automáticamente el enlace de la página actual.
    const rutaActual = window.location.pathname;

    document.querySelectorAll(".menu-lateral a[href]").forEach(function (enlace) {
        const urlEnlace = new URL(enlace.href, window.location.origin);

        if (urlEnlace.pathname === rutaActual) {
            enlace.classList.add("activo");
        }
    });

    // 2. Mostrar u ocultar las contraseñas.
    document.querySelectorAll('input[type="password"]').forEach(function (campo) {
        const boton = document.createElement("button");

        boton.type = "button";
        boton.textContent = "Mostrar contraseña";
        boton.className = "mostrar-contrasena";
        boton.setAttribute("aria-label", "Mostrar u ocultar contraseña");

        boton.addEventListener("click", function () {
            const mostrar = campo.type === "password";

            campo.type = mostrar ? "text" : "password";
            boton.textContent = mostrar ? "Ocultar contraseña" : "Mostrar contraseña";
        });

        campo.insertAdjacentElement("afterend", boton);
    });

    // 3. Evitar que los campos obligatorios contengan solamente espacios.
    document.querySelectorAll("form").forEach(function (formulario) {
        formulario.querySelectorAll("input, textarea").forEach(function (campo) {
            campo.addEventListener("input", function () {
                campo.setCustomValidity("");
            });
        });

        formulario.addEventListener("submit", function (evento) {
            const camposObligatorios = formulario.querySelectorAll(
                "input[required], textarea[required], select[required]"
            );

            camposObligatorios.forEach(function (campo) {
                if (campo.type !== "checkbox" && campo.type !== "radio"
                        && campo.value.trim() === "") {
                    campo.setCustomValidity("Completa este campo.");
                } else {
                    campo.setCustomValidity("");
                }
            });

            if (!formulario.checkValidity()) {
                evento.preventDefault();
                formulario.reportValidity();
            }
        });
    });

    // 4. Establecer la fecha actual como fecha mínima en los calendarios.
    const hoy = new Date();
    const anio = hoy.getFullYear();
    const mes = String(hoy.getMonth() + 1).padStart(2, "0");
    const dia = String(hoy.getDate()).padStart(2, "0");
    const fechaActual = anio + "-" + mes + "-" + dia;

    document.querySelectorAll('input[type="date"]').forEach(function (campo) {
        if (campo.id === "fecha_vencimiento" || campo.name === "fecha_vencimiento") {
            campo.min = fechaActual;
        }
    });

    // 5. Buscar filas de las tablas mientras se escribe.
    document.querySelectorAll('input[type="search"]').forEach(function (buscador) {
        buscador.addEventListener("input", function () {
            const seccion = buscador.closest("section") || document;
            const tabla = seccion.querySelector("table");

            if (!tabla || !tabla.tBodies.length) {
                return;
            }

            const filas = tabla.tBodies[0].rows;
            const texto = buscador.value.trim().toLowerCase();

            Array.from(filas).forEach(function (fila) {
                // No ocultar las filas informativas que usan colspan.
                if (fila.querySelector("td[colspan]")) {
                    return;
                }

                fila.hidden = !fila.textContent.toLowerCase().includes(texto);
            });
        });
    });

});
