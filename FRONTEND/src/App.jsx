import { React, useSate } from 'react';
import { BrowserRouter as Router, Route, Routes} from 'react-router-dom';
import Inscription from './pages/Inscription';

function App() {

  return (
    <>
        <Router>
          <Routes>
            <Route path='/inscription' element={ <Inscription /> } />
          </Routes>
        </Router>
    </>
  )
}

export default App
