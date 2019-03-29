document.addEventListener('DOMContentLoaded', () => {
  const inputarea = document.getElementById('new_post_input');
  inputarea.focus();
  inputarea.addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
      if (event.target.value !== '') {
        App.chat.speak(event.target.value);
        event.target.value = '';
      };
      event.preventDefault();
    };
  });
})
