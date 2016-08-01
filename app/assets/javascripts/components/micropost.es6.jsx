class Micropost extends React.Component {
  render () {
  	var media;
  	if (this.props.has_image) {
			media = <img src={this.props.media} />
		} else if (this.props.has_video) {
			media = <video src={this.props.media} controls="true" preload= "none" poster= {this.props.media_thumb_url} />
		}

		var delete_link;
		if (this.props.current_user) {
			delete_link = <a href= {this.props.delete_path} data-method="delete" data-comfirm="You sure?" rel="nofollow"> delete </a>
		}


    return (
    	<li id={'micropost-' + this.props.id} >
    		<a href={this.props.user_path}><img src={this.props.user_profile_url} className= "gravatar"/></a>
    		<span className="user">
    			<a href={this.props.user_path}> {this.props.user_name} </a>
  			</span>
	      <span className="content">
	  			{this.props.content}
	  			{media}
	  		</span>
	  		<span className="timestamp">
	    		Posted 
	    		{this.props.timestamp}
	    		ago.
	    		{delete_link}
	  		</span>
  		</li>
    );
  }
}

Micropost.propTypes = {
	id: React.PropTypes.number,
  content: React.PropTypes.node,
  delete_path: React.PropTypes.string,
  media: React.PropTypes.string,
  media_thumb_url: React.PropTypes.string,
  has_image: React.PropTypes.bool,
  has_video: React.PropTypes.bool,
  timestamp: React.PropTypes.string,
  user_name: React.PropTypes.string,
  user_path: React.PropTypes.string,
  user_profile_url: React.PropTypes.string,
  current_user: React.PropTypes.bool

};
