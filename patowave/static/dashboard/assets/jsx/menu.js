'use strict';

const e = React.createElement;

class LikeButton extends React.Component {
  constructor(props) {
    super(props);
    this.state = { liked: false };
  }

  render() {
    if (this.state.liked) {
      return 'You liked this.';
    }

    return e(
      'button',
      { onClick: () => this.setState({ liked: true }) },
      'Like'
    );
  }
}

function Overview() {
    return <h1>Overview</h1>
}

// const domContainer = document.getElementById('root');
// const root = ReactDOM.createRoot(domContainer);
// root.render(e(LikeButton));

function setActive(id = 1) {
    for (let index = 1; index < 11; index++) {
        if (index != id) {
            var data = document.getElementById(`menu${index}`)
            data.className = 'menu-item'
        }
    }
    var data = document.getElementById(`menu${id}`)
    data.className = 'menu-item active'
    if (id == 1) {
        const domContainer = document.getElementById('root');
const root = ReactDOM.createRoot(domContainer);
root.render(e(Overview));
    } else {
        
    }
}
setActive(id = 1);