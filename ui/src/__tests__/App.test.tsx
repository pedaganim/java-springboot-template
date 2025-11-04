import { render, screen } from '@testing-library/react'
import '@testing-library/jest-dom'
import App from '../App'

test('renders app root', () => {
  render(<App />)
  expect(screen.getByText(/Hello/i)).toBeInTheDocument()
})
