import { render, screen } from '@testing-library/react'
import '@testing-library/jest-dom'
// Mock API layer to avoid network during tests
vi.mock('../api', () => ({
  listUsers: async () => [],
  createUser: vi.fn(),
  updateUser: vi.fn(),
  deleteUser: vi.fn()
}))
import App from '../App'

test('renders app root', () => {
  render(<App />)
  expect(screen.getByText(/Users/i)).toBeInTheDocument()
})
