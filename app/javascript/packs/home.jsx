import React, { Component, useState, useEffect } from 'react'
import ReactDOM from 'react-dom'

class Home extends Component {
  constructor(props) {
    super(props);

    this.state = {
      term: 'fromage, poulet',
      autoCompleteResults: [],
      itemSelected: {},
      showItemSelected: false
    };

    $.getJSON('recipes/search?ingredients=' + this.state.term)
      .then(response => this.setState({ autoCompleteResults: response.recipes }))
  }

  getAutoCompleteResults(e){
    this.setState({
      term: e.target.value
    }, () => {
      $.getJSON('recipes/search.json?ingredients=' + this.state.term)
        .then(response => this.setState({ autoCompleteResults: response.recipes }))
    });
  }

  render(){
    let autoCompleteList = this.state.autoCompleteResults.map((response, index) => {
      console.log(response)
      return <div key={index}>
      <a href={'recipes/' + response.id}>{response.name } ({response.difficulty }, {response.prep_time }, {response.budget })</a>

      </div>
    });

    return (
      <div>
        <h3> Search recipes </h3>
        <textarea rows='3' cols='35' ref={ (input) => { this.searchBar = input } } value={ this.state.term } onChange={ this.getAutoCompleteResults.bind(this) } type='text' placeholder='Search...' />
        { autoCompleteList }
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Home />,
    document.body.appendChild(document.createElement('div')),
  )
});

// document.addEventListener('DOMContentLoaded', () => {
//   ReactDOM.render(
//     <Hello name="React" />,
//     document.body.appendChild(document.createElement('div'))
//   )
// })
