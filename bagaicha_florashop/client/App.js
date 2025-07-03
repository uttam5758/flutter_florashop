import React, { useState } from 'react';
import axios from 'axios';

function App() {
  const [form, setForm] = useState({ username: '', password: '' });
  const [token, setToken] = useState('');
  const [message, setMessage] = useState('');

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const signup = () => {
    axios.post('http://localhost:5000/api/signup', form)
      .then(res => alert(res.data.message))
      .catch(err => alert(err.response.data.message));
  };

  const login = () => {
    axios.post('http://localhost:5000/api/login', form)
      .then(res => {
        setToken(res.data.token);
        alert("Login successful");
      })
      .catch(err => alert(err.response.data.message));
  };

  const getDashboard = () => {
    axios.get('http://localhost:5000/api/dashboard', {
      headers: { Authorization: `Bearer ${token}` }
    }).then(res => setMessage(res.data.message))
      .catch(err => alert(err.response.data.message));
  };

  return (
    <div>
      <h2>Login / Signup</h2>
      <input name="username" onChange={handleChange} placeholder="Username" /><br />
      <input name="password" type="password" onChange={handleChange} placeholder="Password" /><br />
      <button onClick={signup}>Sign Up</button>
      <button onClick={login}>Login</button>
      <button onClick={getDashboard}>Dashboard</button>
      <p>{message}</p>
    </div>
  );
}

export default App;
    