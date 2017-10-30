=begin
The Node Package is the basic building block of the Abstract Data Structures in this Library.
=cut
package Node;
sub new {
	my $self = {};
	bless($self, "Node");
}
sub get_data {
	my $self = shift;
	return $self->{data};
}
sub set_data {
	my $self = shift;
	$self->{data} = shift;
}

sub get_next {
	my $self = shift;
	return $self->{next_node};
}

sub set_next {
	my $self = shift;
	$self->{next_node} = shift;
}

=begin
The TwoLinkedNode Package
=cut
package TwoLinkedNode;
sub new {
	my $self = {};
	bless($self, "TwoLinkedNode");
}

sub get_data {
	my $self = shift;
	return $self->{data};
}

sub set_data {
	my $self = shift;
	$self->{data} = shift;
}

sub get_prev {
	my $self = shift;
	return $self->{prev};
}

sub get_next {
	my $self = shift;
	return $self->{next};
}

sub set_prev {
	my $self = shift;
	$self->{prev} = shift;
}

sub set_next {
	my $self = shift;
	$self->{next} = shift;
}
=begin
The Stack Package
=cut
package Stack;
sub new {
	my $self = {};
	$self->{size} = 0;
	$self->{top_node} = undef;
	bless($self, "Stack");
}

sub push {
	my $self = shift;
	my $data = shift;
	my $node = Node->new();
	$node->set_data($data);
	if ($self->{top_node} == undef) {
		$self->{top_node} = $node;
	} else {
		my $nextnode = $self->{top_node};
		$node->set_next($nextnode);
		$self->{top_node} = $node;
	}
	$self->{size}++;
}

sub pop {
	my $self = shift;
	if ($self->{top_node} == undef) {
		return undef;
	}
	my $return_value = $self->{top_node};
	$self->{top_node} = $return_value->get_next();
	$self->{size}--;
	return $return_value->get_data();
}

sub peek {
	my $self = shift;
	my $node = $self->{top_node};
	return $node->get_data();
}

=begin
The Queue Package
=cut

package Queue;
sub new {
	my $self = {};
	$self->{size} = 0;
	$self->{begin} = undef;
	$self->{end} = undef;
	bless($self, "Queue");
}

sub push {
	my $self = shift;
	$data = shift;
	my $node = TwoLinkedNode->new();
	$node->set_data($data);
	if ($self->{size} == 0) {
		$self->{begin} = $node;
		$self->{end} = $node;
	} elsif ($self->{size} == 1){
		$self->{begin} = $node;
		$self->{end}->set_prev($node);
		$self->{begin}->set_next($self->{begin});
	} else {
		
	}
	$self->{size}++;
}

sub look {
	my $self = shift;
	return $self->{end}->get_data();
}

sub peek {
	my $self = shift;
	return $self->{begin}->get_data();
}

sub pop {
	my $self = shift;
	my $result = undef;
	if ($self->{size} == 0) {
		return undef;
	} 
	$self->{size}--;
	return $result;
}

=begin
The Double Ended Queue (DeQue)
=cut

package DeQue;
sub new {
	my $self = {};
	$self->{size} = 0;
	$self->{begin} = undef;
	$self->{end} = undef;
	bless($self, "DeQue");
}

=begin
The Single LinkedList Package
=cut
package LinkedList;
sub new {
	my $self = {};
	$self->{size} = 0;
	$self->{top_node} = undef;
	bless($self, "Single-LinkedList");
}

sub push {
	my $self = shift;
	my $data = shift;
	my $node = Node->new();
	$node->set_data($data);
	if ($self->{top_node} == undef) {
		$self->{top_node} = $node;
	} else {
		my $nextnode = $self->{top_node};
		$node->set_next($nextnode);
		$self->{top_node} = $node;
	}
	print $self->{top_node}->get_data();
	$self->{size}++;
}

sub pop {
	my $self = shift;
	if ($self->{top_node} == undef) {
		return undef;
	}
	my $return_value = $self->{top_node};
	$self->{top_node} = $return_value->get_next();
	$self->{size}--;
	return $return_value->get_data();
}

sub peek {
	my $self = shift;
	my $node = $self->{top_node};
	return $node->get_data();
}

sub append {
	my $self = shift;
	my $data = shift;
	if ($self->{top_node} == undef) {
		$self->{top_node} = Node->new($data);
	} else {
		$self->push_next($self->{top_node}, $data);
	}
	$self->{size}++;
}

sub remove {
	my $self = shift;
	my $dataToRemove = shift;
	my $topNode = $self->{top_node};
	if ($topNode->get_data() == $dataToRemove) {
		my $return_value = $self->{top_node};
		$self->{top_node} = $return_value->get_next();
		$self->{size}--;
		return $return_value->get_data();
	} else {
		$self->help_remove($self->{top_node}, $self->{top_node}->get_next(), $dataToRemove);
	}
}

sub help_remove {
	my $self = shift;
	my $prevNode = shift;
	my $curNode = shift;
	my $dataToRemove = shift;
	if ($curNode == undef) {
		return undef;
	}
	if ($curNode->get_data() == $dataToRemove) {
		$value = $curNode->get_data();
		$prevNode->{next_node} = $curNode->{next_node};
		$self->{size}--;
		return $value;
	} else {
		$self->help_remove($curNode, $curNode->get_next(), $dataToRemove);
	}
}

sub map {
	my $self = shift;
	my $function = shift;
	if ($self->{top_node} == undef) {
		return undef;
	} else {
		$self->apply_function($self->{top_node}, $function);
	}
}

sub apply_function {
	my $self = shift;
	my $node = shift;
	my $function = shift;
	my $data = $node->{data};
	$node->{data} = $function->($data);
	if ($node->{next_node} != undef) {
		$self->apply_function($node->{next_node}, $function);
	}
}

sub return_size {
	my $self = shift;
	return $self->{size};
}

sub push_next {
	my $self = shift;
	my $node = shift;
	my $data = shift;
	if ($node->{next_node} == undef) {
		$node->set_data($data);
	} else {
		$self->push_next($node->{next_node}, $data);
	}
}
