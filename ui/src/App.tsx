import { useEffect, useState } from 'react'

export default function App() {
  const [message, setMessage] = useState<string>('Loading...')

  useEffect(() => {
    fetch('/api/hello')
      .then(r => r.text())
      .then(setMessage)
      .catch(() => setMessage('Backend not reachable. Start Spring Boot on :8080'))
  }, [])

  return (
    <div style={{
      display: 'grid', placeItems: 'center', height: '100dvh',
      fontFamily: 'Inter, system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Cantarell, Noto Sans, Helvetica Neue, Arial, "Apple Color Emoji", "Segoe UI Emoji"'
    }}>
      <div>
        <h1>Hello from React + TS</h1>
        <p>Backend says: <strong>{message}</strong></p>
      </div>
    </div>
  )
}
