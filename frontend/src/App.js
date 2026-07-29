import React, { useEffect, useState } from 'react';
import './App.css';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:8000';

function App() {
  const [status, setStatus] = useState('loading');

  useEffect(() => {
    fetch(`${API_URL}/api/health/`)
      .then((res) => res.json())
      .then(() => setStatus('ok'))
      .catch(() => setStatus('error'));
  }, []);

  return (
    <div className="container">
      <h1>Frontend is running</h1>
      <p>Talking to Django backend at: <code>{API_URL}</code></p>
      <span className={`status ${status}`}>
        {status === 'loading' && 'Checking backend...'}
        {status === 'ok' && 'Backend connected ✓'}
        {status === 'error' && 'Backend unreachable ✗'}
      </span>
    </div>
  );
}

export default App;
