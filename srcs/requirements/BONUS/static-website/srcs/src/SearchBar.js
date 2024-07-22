/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   SearchBar.js                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hdeniz <Discord:@teomandeniz>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/07/22 12:48:13 by hdeniz            #+#    #+#             */
/*   Updated: 2024/07/22 12:51:01 by hdeniz           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

import React, { useState } from 'react';
import './SearchBar.css';

function SearchBar({ onSearch })
{
	const [pokemonName, setPokemonName] = useState('');

	const handleChange = (event) =>
	{
		setPokemonName(event.target.value);
	};

	const handleClick = () =>
	{
		if (pokemonName.trim() !== '')
			onSearch(pokemonName.toLowerCase());
	};

	return (
		<div style={{ textAlign: 'center' }}>
			<input 
				onChange={handleChange}
				className="search-input" 
				type="text" 
				placeholder="What Pokémon will you choose?" />
			<button onClick={handleClick} className="search-button">Search</button>
		</div>
	);
}

export default SearchBar;