import './styles/style.css';
import { handleButtonClick } from './calculator';

const display = document.querySelector('.calculator__display');
const buttons = document.querySelectorAll('.calculator__buttons button');

let expression = '';

buttons.forEach(button => {
  button.addEventListener('click', () => {
    const value = button.getAttribute('data-value');
    if (value) {
      expression = handleButtonClick(value, expression);
    }

    if (display) {
      display.textContent = expression;
    }
  });
});