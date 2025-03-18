def dhondt_method(parties_votes, seats):
    total_votes = sum(i[0] for i in parties_votes)  
    dhondt_table = []
    filtered_votes = [i for i in parties_votes if i[0] > total_votes * 0.05]

    for i in range(len(filtered_votes)):
        for j in range(1, seats + 1):
            divided_votes = filtered_votes[i][0] // j
            party_name = filtered_votes[i][1]
            dhondt_table.append((divided_votes, party_name))

    dhondt_table.sort(key=lambda x: x[0], reverse=True)
    allocated_seats = {}

    for i in range(seats):
        party_name = dhondt_table[i][1]
        if party_name not in allocated_seats:
            allocated_seats[party_name] = 0
        allocated_seats[party_name] += 1

    return allocated_seats

print(dhondt_method([(720, "A"), (500, "B"), (900, "C")], 10))
