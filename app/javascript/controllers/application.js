import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
document.addEventListener("DOMContentLoaded", function () {
    const deleteButtons = document.querySelectorAll(".delete-button");
  
    deleteButtons.forEach((button) => {
      button.addEventListener("click", function (event) {
        event.preventDefault(); // Ngăn chặn hành động mặc định
        const form = button.closest("form");
  
        Swal.fire({
          title: "Are you sure?",
          text: "You won't be able to revert this action!",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#d33",
          cancelButtonColor: "#3085d6",
          confirmButtonText: "Yes, delete it!",
        }).then((result) => {
          if (result.isConfirmed) {
            form.submit(); // Gửi biểu mẫu nếu người dùng xác nhận
          }
        });
      });
    });
  });
  
