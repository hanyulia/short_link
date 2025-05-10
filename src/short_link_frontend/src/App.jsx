import React, { useState, useEffect } from 'react';
import { short_link_backend } from 'declarations/short_link_backend';
import './index.scss';

function App() {
  const [url, setUrl] = useState('');
  const [shortCode, setShortCode] = useState('');
  const [linkList, setLinkList] = useState([]);

  const createShort = async () => {
    if (!url) return;
    const code = await short_link_backend.createShortLink(url);
    setShortCode(code);
    setUrl('');
    fetchLinks();
  };

  const fetchLinks = async () => {
    const links = await short_link_backend.getAllLinks();
    setLinkList(links);
  };

  useEffect(() => {
    fetchLinks();
  }, []);

  return (
    <div className="app-container">
      <h1>🔗 ICP Short Link</h1>
      <div className="input-group">
        <input
          type="text"
          value={url}
          onChange={(e) => setUrl(e.target.value)}
          placeholder="Paste long URL here"
        />
        <button onClick={createShort}>Shorten</button>
      </div>

      {shortCode && (
        <div className="result">
          Short link created: <strong>{window.location.origin + '/?q=' + shortCode}</strong>
        </div>
      )}

      <h2>📄 All Short Links</h2>
      <ul className="link-list">
        {linkList.map((link, i) => (
          <li key={i}>
            <a href={link.fullURL} target="_blank" rel="noopener noreferrer">
              {window.location.origin + '/?q=' + link.shortCode}
            </a> → {link.fullURL}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
